void print(const char* str) {
    unsigned short* video = (unsigned short*)0xB8000;
    for (int i = 0; str[i]; ++i)
        video[i] = (0x0F << 8) | str[i];
}

void kernel_main() {
    print("Hello from 32-bit kernel!");
    while (1);
}