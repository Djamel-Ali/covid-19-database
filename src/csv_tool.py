def remove_double_quote(string: str) -> str:
    return string.replace("\"", "")


def to_str(string: str) -> str:
    return f"'{string}'"

def str_to_str(string: str) -> str:
    return to_str(remove_double_quote(string))

def to_int(string: str) -> str:
    return str(int(string))


def str_to_int(string: str) -> str:
    return to_int(remove_double_quote(string))


def int_or_null(string: str) -> str:
    return "NULL" if string == "NA" else str(int(string))


def to_date(string: str, format: str = "YYYY-MM-DD") -> str:
    return f"TO_DATE({to_str(string)}, '{format}')"


def str_to_date(string: str, format: str = "YYYY-MM-DD") -> str:
    return to_date(remove_double_quote(string), format)
