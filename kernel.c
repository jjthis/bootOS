
void kernel_print();
void kernel_entrypoint_main()
{
    kernel_print();

    while (1);
}



void kernel_print(){
    char* screen = (char*)0xB8000;

    const char* message = "Hello, World!fdsgfdhgdfggf";

    for (int i = 0; message[i] != 0; ++i)
    {
        *screen = message[i];
        screen += 2;
    }
}	
