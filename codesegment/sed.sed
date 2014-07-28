# 操作的范围是1到3行
#1, 3{
#s/my/wnb's/g
#s;my;wnb's;g
#}

{
3,6s/my/your/g #替换3到6行
}
{
3s/your/yours/g #只替换第3行
}

{
s/s/S/2g #替换第2个以后的s
}

# 操作行是所有行
{
s/^/#/g
s/$/ --- /g
#s/\<m/wnb/g #以m开头的单词
}

# 过滤html
{
s/<[^>]*>//g
}

{
#N;
#s/my/your/ #将下一行命令纳入当成缓冲区做匹配，并且只做一次操作
N;
s/\n/,/ #上一条命令的解释
}

{
1 i this is insert line #在第1行前插入一行,忽略i后面的到具体内容之间的空格
1 a this is append line #在第一行后添加一行,忽略a后面的到具体内容之间的空格
1athis is append line
1a:this is append line
/my/a --- # 在含有my的行后面添加数据
}

{
2 c change 2 lines # 将整个第2行内容替换
/fish/c change fish lines # 替换含有fish行的内容
}

{
/fish/d # 删除含有fish的行
2d # 删除两行
2,$d # 从第2行起删除
}

{
/fish/p #打印含有fish的行, 这样会输出两遍，sed处理时会把处理的信息输出
/dog/,/fish/p #打印从匹配dog到匹配fish的内容, 只会匹配到第一个fish处
1,/fish/p #从第一行打印到匹配fish的内容, 只会匹配到第一个fish处
}

{
:top
s/my/your/
/fish/b top #跳转到top，这样可能会形成死循环
}