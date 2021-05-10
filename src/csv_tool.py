def str_to_int(string: str) -> str:
    return string.replace("\"", "")


def int_or_null(string: str) -> str:
    return "NULL" if string == "NA" else str(int(string))


def to_str(string: str) -> str:
    return f"'{string}'"


def to_date(string: str, format: str) -> str:
    return f"TO_DATE({to_str(string)}, '{format}')"
