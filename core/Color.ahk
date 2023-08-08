Class Color{
    __New(colorId) {
        this.c := '0x' . StrUpper(SubStr(colorId, 2, 6))
    }
}