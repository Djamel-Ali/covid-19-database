def print_head(msg: str):
    start = "| "
    end = " |"
    line = "-" * (len(msg) + len(start) + len(end))
    print(line)
    print(start + msg + end)
    print(line)
