# Complete the method/function so that it converts dash/underscore delimited words into camel casing. 
# The first word within the output should be capitalized only if the original word was capitalized 
# (known as Upper Camel Case, also often referred to as Pascal case). 
# The next words should be always capitalized.

# Examples
# "the-stealth-warrior" gets converted to "theStealthWarrior"
# "The_Stealth_Warrior" gets converted to "TheStealthWarrior"
# "The Stealth Warrior" gets converted to "TheStealthWarrior"

def solution(string):
    output = ''
    next_upper = False
    for char in string:
        if char in {'-', "_", " "}:
            next_upper = True
        elif next_upper:
            output += char.upper()
            next_upper = False
        else:
            output += char
    return output

import re
def solution(string):
    return re.sub('[\W_]+\w', lambda match: match.group()[-1].upper(), string)



# print(solution("this is another example, that_is_going to have--multiple-weird__spacing"))

# def solution(words):
#     words = words.replace("-", " ")
#     words = words.replace("_", " ")
#     words = words.split()
#     for i in range(1, len(words)):
#             words[i] = words[i].title()
#     words = ''.join(words)
#     return words

# def solution(a_string):
#     if not a_string:
#         return ""
#     first_letter = a_string[0]
#     print(first_letter)
#     rest = a_string.title()
#     print(rest)
#     rest2 = []
#     for char in rest:
#         if char.isalpha():
#             rest2.append(char)
#     print(rest2)
#     rest3 = ''.join(rest2)
#     print(rest3)
#     return first_letter + rest3[1:]

# print(solution("hello_world"))