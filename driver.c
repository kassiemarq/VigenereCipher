#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
void toUpper(char* msg, int strlength);
void manipKey(char *key, int keylength, int strlength);
void vigenereCipherEncrypt(char *msg, char *key, char *newMsg);
void vigenereCipherDecrypt(char *msg, char *key, char *newMsg);

int strLength(char *msg);
void options(int x);
int main(void){
int x = 0;
printf("What would you like to do today?\n\n");
printf("Please type in the corresponding number to the option, then hit SPACEBAR or ENTER.\n");
printf("1.ENCRYPT OR DECRYPT A MESSAGE\n");
printf("2.QUIT\n");
options(x);
printf("Goodbye!\n");
}//end main----------------------------------------------------------------------------------------------------------
void options(int x){
scanf("%d", &x);
if(x == 1){
char *a;
a = malloc(sizeof(char) * 100);
printf("Please type a message to be encrypted OR decrypted...\n");
printf("Then press SPACEBAR or ENTER for program to read.\n\n");
scanf("%s",a);
printf("Your word is: ");
printf("%s\n\n",a);
a = realloc(a, sizeof(a));
printf("Please type in a 'key' you would like to use OR used.\n");
char *key;
//key = maalloc(sizeof(char)*sizeof(a));
scanf("%s",key);
printf("Your key is: ");
printf("%s\n\n",key);
int strlength = strLength(a);
int keylength = strLength(key);
printf("Converting your message & key to uppercase...\n\n");
toUpper(key,keylength);
toUpper(a,strlength);

printf("Now your key has been converted to all uppercase.... %s\n", key);
toUpper(a,strlength);
printf("Now your message has been converted to all uppercase....%s\n\n",a);
printf("Now checking to see if your key is the same length of your message...\n");
manipKey(key, keylength, strlength);
printf("Now converting...your key is now: %s\n\n", key);
printf("Checking if string lengths match...\n");
strlength = strLength(a);
keylength = strLength(key)
printf("The string length of your key is: %d\n", keylength);
printf("The string length of your message is: %d\n\n", strlength);
char *encryptedMsg = malloc(sizeof(char) * sizeof(a));
printf("encrypted msg %s\n", encryptedMsg);
printf("Now perform Vigenere Cipher...\n");
vigenereCipherEncrypt(a, key, encryptedMsg);
printf("Your message is %s\n", encryptedMsg);
/*
int choice = 0;
printf("Last equation: Are you encrypting or decrypting?\n");
printf("Please input the number to the corresponding option.\n\n");
printf("1. ENCRYPTION\n");
printf("2. DECRYPTION\n");
scanf("%d\n", & choice);
printf("%d\n", choice);
if(scanf("%d",&choice)){
printf("%d\n", choice);
if(choice == 1){
printf("Now perform Vigenere Cipher...\n");
vigenereCipherEncrypt(a, key, encryptedMsg);
printf("Your message is %s", encryptedMsg);
}
else if(choice == 2){
printf("Now perform Vigenere Cipher...\n");

vigenereCipherDecrypt(a, key, encryptedMsg);
printf("Your message is %s", encryptedMsg);
}
else
printf("Wrong integer input. Program will terminate.\n");
}
else
printf("Wrong input. Program will now terminate.\n");
*/
}//END ENCRYPT/DECYPT
else if( x == 2 ){
}
else{
printf("Wrong input. Program will terminate.\n");
}//end INVALID
