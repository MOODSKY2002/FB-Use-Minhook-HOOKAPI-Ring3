#Include "windows.bi"
#Ifdef __FB_64BIT__
    #INCLIB "zip_64"                             ' the lib name is : libzip_64.a
#Else
    #INCLIB "zip_32"                             ' the lib name is : libzip_32.a
#Endif

extern "C"
    declare Function z_compress alias "z_compress"(byref pDest as ubyte ptr , byval pInitial as ubyte ptr , byval Initial_len as ulong , byval level as ulong) as long
    declare Function z_uncompress alias "z_uncompress"(byref pDest as ubyte ptr , byval pComp as ubyte ptr , byval comp_len as ulong) as long

    declare Function z_compressBound alias "z_compressBound"(byval Initial_len as ulong) as ulong ' conservative information
    declare Function z_UncompLen alias "z_UncompLen"(byval pComp as ubyte ptr) as ulong ' precise information, gets from compressed header file
end extern
'#INCLIB "madCHook32md.a"

messagebox 0,"123","",0