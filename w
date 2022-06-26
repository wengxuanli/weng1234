#include<stdio.h>
#include<string.h>
#include<stdlib.h>

#define MAX_ARRAY_LENGTH 10000

struct Account
{
	char username[20];
	char password[7];
	float money;
};

struct Account account[MAX_ARRAY_LENGTH];
int accountCnt = 0;

int curAccountIndex; //record current account
int otherAccountIndex; //record other account

char* filename = "D:/atm_account.txt";

void signUp()
{
	printf("Username:");
	scanf("%s", account[accountCnt].username);

	printf("Password:");
	scanf("%s", account[accountCnt].password);

	account[accountCnt].money = 1000.f; //you can also set it to 0.f
	
	accountCnt++; 
	printf("success!\n");
	system("pause");
}

//return 1 if find the temporary account
int findAccount(struct Account tempAccount)
{
	int i;
	for(i=0;i<accountCnt;i++)
	{
		if((strcmp(account[i].username,tempAccount.username)==0)&&(strcmp(account[i].password,tempAccount.password)==0))
		{
			curAccountIndex = i;
			return 1;
		}
	}
	return 0;
}

//return 1 if find the other username
int findOtherAccount(char otherUsername[])
{
	int i;
	for(i=0;i<accountCnt;i++)
	{
		if(strcmp(account[i].username,otherUsername)==0)
		{
			otherAccountIndex = i;
			return 1;
		}
	}
}

void drawMoney()
{
	int money;
	printf("Money:");
	scanf("%d",&money);

	if(account[curAccountIndex].money>=money)
	{
		account[curAccountIndex].money-=money;
		printf("Success!\n");
	}
	else
	{
		printf("Money is not enough!\n");
	}
}

void saveMoney()
{
	int money;
	printf("Money:");
	scanf("%d",&money);

	account[curAccountIndex].money+=money;
	printf("Success!\n");
}

void transfer()
{
	char otherUsername[100];
	printf("Other Account:");
	scanf("%s",otherUsername);

	if(findOtherAccount(otherUsername))
	{
		int money;
		printf("Money:");
		scanf("%d",&money);

		if(account[curAccountIndex].money>=money)
		{
			account[curAccountIndex].money-=money;
			account[otherAccountIndex].money+=money;
			printf("Success!\n");
		}
		else
		{
			printf("Money is not enough!\n");
		}
	}
	else
	{
		printf("Invalid Input!\n");
	}
}

void homePage()
{
	while(1)
	{
		int choice;

		system("cls");

		printf("\t\t\tWelcome to Loving C Bank\n");
		printf("\t1.Draw Money");
		printf("\t2.Save Money");
		printf("\t3.Transfer");
		printf("\t4.Back\n");

		scanf("%d", &choice);
		if(choice == 1)
		{
			drawMoney();
			system("pause");
		}
		else if(choice == 2)
		{
			saveMoney();
			system("pause");
		}
		else if(choice == 3)
		{
			transfer();
			system("pause");
		}
		else if(choice == 4)
		{
			break;
		}
		else
		{
			printf("Invalid Input\n");
			system("pause");
		}
	}
}

void signIn()
{
	int i;
	for(i=0;i<3;i++)
	{
		struct Account tempAccount;

		printf("Username:");
		scanf("%s", tempAccount.username);

		printf("Password:");
		scanf("%s", tempAccount.password);

		if(findAccount(tempAccount))
		{
			homePage();
			break;
		}
		else
		{
			printf("Username or Password Error\n");
		}
	}
}

void saveData()
{
	int i;
	FILE * fp = fopen(filename,"w");
	if(fp!=NULL)
	{
		for(i=0;i<accountCnt;i++)
		{
			fprintf(fp,"%s %s %f\n",account[i].username,account[i].password,account[i].money);
		}
		fclose(fp);
	}
}

void loadData()
{
	FILE * fp=fopen(filename,"r");
	if(fp!=NULL)
	{
		while(fscanf(fp,"%s %s %f\n",account[accountCnt].username,account[accountCnt].password,&account[accountCnt].money)!=EOF)
		{
			accountCnt++;
		}
		fclose(fp);
	}
}

int main()
{
	loadData();

	while(1)
	{
		int choice;
		system("cls");
		printf("\t\t\tWelcome to Loving C Bank\n");
		printf("\t\t1.Sign Up");
		printf("\t2.Sign In");
		printf("\t3.Exit\n");
		
		scanf("%d", &choice);
		
		if(choice == 1)
		{
			signUp();
		}
		else if(choice == 2)
		{
			signIn();
		}
		else if(choice == 3)
		{
			break;
		}
		else
		{
			printf("Invalid Input\n");
			system("pause");
		}
	}

	saveData();

	return 0;
}
