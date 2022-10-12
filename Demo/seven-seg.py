import fileinput

TEMPLATE='''
\033[2J\033[1;1f
    AAAAAAAAA
   FF       BB
   FF       BB
   FF       BB
   FF       BB
    GGGGGGGGG
   EE       CC
   EE       CC
   EE       CC
   EE       CC
    DDDDDDDDD
'''
BLOCK={
    0:'\033[37m▒\033[0m',
    1:'\033[31m▒\033[0m'
}
VARS='ABCDEFG'

for v in VARS:
    globals()[v]=0#定义全局变量
stdin=fileinput.input()

while(True):
    input=stdin.readline()
    exec(input)#更新变量
    pic=TEMPLATE
    for v in VARS:
        pic=pic.replace(v,BLOCK[globals()[v]])
    print(pic)