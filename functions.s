.global strLength
.data
.text
strLength:
mov r12,r13
sub sp,#32
push {lr}
//we're passing in the array of key or the array of message
//first we need to find the string length.
//let r5 be our counter for our string length
mov r5, #0 //initialize r5 = 0
mov r6,r0 //we don't want to mess with the address of our arg, so, we'll just move it into a diff
register.
while:
ldrb r1,[r6] //we're loading a byte of r6, so essentially r1 = key[0]
cmp r1, #0 // is r1 = 0? then we've reached the end of the string. you're done!
beq done

//else if it isn't null, then length++ ( r5 )
add r5, r5, #1
//then we need to load the next byte.
add r6, r6, #1

//cycle repeats till we reach null.
b while
done:
mov r0, r5 //return the length.
pop {r7}
mov lr, r7
mov sp,r12
mov pc, lr
//*******************************************************************
.global toUpper //returns char* toUpper(msg[MAX])
.data
.text
toUpper:
mov r12,r13
sub sp,#32
push {lr}
//r0 has address of key[MAX]
//r1 has strlength
//let r2 be your walking stick thru array.
mov r2,#0
loop:
cmp r1, r2 //cmp (strlength-1) with the inc, are they the same? then we reached the end,nothing more
to inc.
beq exit
ldrb r3,[r0,r2] //so right now we loaded into r3, max[0]

cmp r3, #0 //another condition to check that we reached the end.
//first test:if null, we reached the end, nothing to upper. we're done.
beq exit

cmp r3, #'a' //second test:is r1 less than 97 'a'? then we're already uppercase.
blt exit
//else if its not, then we're lower case. so we must sub 0x20.
sub r3, r3, #0x20
strb r3,[r0,r2] //this stores the value of r1 into address of r0, inc by r2(our walking stick)
add r2,r2,#1

b loop
//then we need to load the next byte.
//cycle repeats till we reach null.
exit:
pop {r7}
mov lr, r7
mov sp,r12
mov pc, lr
//******************************************************
.global manipKey //remember manipKey(char key[MAX], int strlength, int keylength)
.data
.text
manipKey:

mov r12,r13
sub sp,#32
push {lr}
//r0 holds address of key
//r1 holds length of the key
//r2 holds the length of the message
//r4 is our walking stick thru the array
mov r4, #0
loopdeloop:
cmp r1,r2 //are they equal? then you dont need to do anywork:)
beq overit
//else if keylength > messagelength, we got to nullify some ofit

bgt nullify
//else, keylength < messagelength, we need to make the length the same
//lets use r3 to hold the address of the first element array
ldrb r3,[r0,r4]
//store the value of r3 into the array's next element thats open!
strb r3,[r0,r1]
//now we inc the keylength since thats what we did
add r1,r1,#1
add r4,r4,#1 //now we inc our walking stick to move on to the next element
b loopdeloop
//case where key length is greater so we need to throw away some chars
nullify:

mov r4, r1 //let r4 be the walking stick, grab the length of key
sub r4,r4,#1 //sub r4 - 1 bc in array we start at 0.

nullifyloop:
cmp r1, r2 //is strlength = keylength? if it is were done.
beq overit

//else lets throw away some chars.
ldrb r3,[r0,r4] //load into r3 key[r4]
mov r3, #0 //nullify that place until strlength = keylength
strb r3,[r0,r4]
sub r4,r4, #1 //dec to move in the array
sub r1,r1,#1 //dec the keylength to check in the end if strlength = keylength
b nullifyloop
overit:
pop {r7}
mov lr, r7
mov sp,r12
mov pc, lr

//***************************************************************
.global vigenereCipherEncrypt
.data
.text
vigenereCipherEncrypt://recall args: vigenereCipher(char msg[MAX], char key[MAX], char
newMsg[MAX]);
mov r12,r13
sub sp,#32
push {lr}

//r0 = holds address of msg[0]
//r1 = holds address of key[0]
//r2 = holds address of our new array newMsg [0] (encrypted message / or decrypted)
//use r3 as a place holder to manipulate the content of msg[]
//use r4 as a place holder to manipulate content of key[]
//r5 is walking stick (i)
//r6 is place holder for the result of the vigenere cipher
mov r5, #0 //i = 0, walking stick
repeat:
ldrb r3,[r0,r5] //r3 gets msg[i]
cmp r3, #0 //did you get null? we reached the end of the string:) we're odne
beq finally
sub r3,r3, #65 // else, lets map the char to #
ldrb r4,[r1,r5] //lets load key[i] into r4
sub r4,r4, #65 //lets map their char to # too
add r6,r3,r4 //lets add the mapped numbers to get our converted char
add r6,r6,#65 //map them to ascii values
cmp r6, #90 //check if we went out of bounds!
bgt modulo //if it is out of bounds, we need to make it work
//else we'll keep going
strb r6,[r2,r5] //store value of r6 into newmsg[i]
add r5,r5,#1 //inc the walking stick
b repeat
//case for when it got out of bounds

modulo:
sub r6,r6,#26 //we sub 26 (26 chars from alphabet) to make it out of bounds
//and get mapped to its ascii value
strb r6,[r2,r5] //now take result and put it in newmsg[i]
add r5,r5,#1 //inc the walking stick
b repeat //branch to repeat.
finally:
pop {r7}
mov lr, r7
mov sp,r12
mov pc, lr
//*********************************************************************************
***
.global vigenereCipherDecrypt
.data
.text
vigenereCipherDecrypt:
mov r12,r13
sub sp,#32
push {lr}
mov r5, #0 //i = 0, walking stick
repeat1:
ldrb r3,[r0,r5] //r3 gets msg[i]
cmp r3, #0 //did you get null? we reached the end of the string:) we're odne
beq finally1
sub r3,r3, #65 // else, lets map the char to #
ldrb r4,[r1,r5] //lets load key[i] into r4
sub r4,r4, #65 //lets map their char to # too
cmp r3,r4
blt map // if r3 < r4, then subtraction will result in -, which cannot happen.
//therefore go to map label.
//PERFORMING DECRYPTION
//else if r3> r4, we can perform subtraction
sub r6,r3,r4 //lets add the mapped numbers to get our converted char

add r6,r6,#65 //map them to ascii values
cmp r6, #90 //check if we went out of bounds!
bgt modulo1 //if it is out of bounds, we need to make it work
//else we'll keep going
strb r6,[r2,r5] //store value of r6 into newmsg[i]
add r5,r5,#1 //inc the walking stick
b repeat1
//case for when it got out of bounds
modulo1:
sub r6,r6,#26 //we sub 26 (26 chars from alphabet) to make it out of bounds
//and get mapped to its ascii value
strb r6,[r2,r5] //now take result and put it in newmsg[i]
add r5,r5,#1 //inc the walking stick
b repeat1 //branch to repeat.
map://case where r3 < r4
sub r6,r4,r3 //r6 = r4-r3
add r6,r6, #10
add r6,r6,#65 //map them to ascii values
cmp r6, #90 //check if we went out of bounds!
bgt modulo1 //if it is out of bounds, we need to make it work
//else we'll keep going
strb r6,[r2,r5] //store value of r6 into newmsg[i]
add r5,r5,#1 //inc the walking stick
b repeat1
finally1:
pop {r7}
mov lr, r7
mov sp,r12
mov pc, lr
