现有两个Skills目录：`~/.agents/skills/`、`~/.claude/skills/`。

编写一个可在Windows Git Bash中运行的脚本，路径为`[proj]/local-install.sh`。

该脚本的流程为：

1. 读取`[proj]/skills`目录下的所有一级子目录的名称。
2. 将上一步读取到的每个子目录，分别在上述的两个Skills目录下建立符号链接（若某个Skill目录下已存在同名目录或符号链接，则先删除已存在的）。
