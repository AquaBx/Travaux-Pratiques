from function import *

print("\n-------- Exo 28 --------\n")
#Exo 28: Code Morse

dict_morse={
    'A':'.-',
    'B':'-...',
    'C':'-.-.',
    'D':'-..',
    'E':'.',
    'F':'..-.',
    'G':'--.',
    'H':'....',
    'I':'..',
    'J':'.---',
    'K':'-.-',
    'L':'.-..',
    'M':'--',
    'N':'-.',
    'O':'---',
    'P':'.--.',
    'Q':'--.-',
    'R':'.-.',
    'S':'...',
    'T':'-',
    'U':'..-',
    'V':'...-',
    'W':'.--',
    'X':'-..-',
    'Y':'-.--',
    'Z':'--..',
}

print('traduire_texte_vers_morse("LE CHAT EST NOIR",dict_morse)',traduire_texte_vers_morse("LE CHAT EST NOIR",dict_morse))
print('reverse_dict(dict_morse)',reverse_dict(dict_morse))
print('traduire_morse_vers_texte(".-.. .  -.-. .... .- -  . ... -  -. --- .. .-.",dict_morse)',traduire_morse_vers_texte(".-.. .  -.-. .... .- -  . ... -  -. --- .. .-.",dict_morse))
