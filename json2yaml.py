#!/usr/bin/env python3

import sys
import json
import yaml


def main():
    std_input = ""
    while True:
        try:
            line = input()
        except EOFError:
            break
        std_input += line

    try:
        json_in = json.loads(std_input)
        print(yaml.dump(json_in))
    except json.JSONDecodeError as e:
        print("No valid json: {}".format(e.msg))
    except Exception as e:
        print("Error: {}".format(e.msg))


if __name__ == '__main__':
    sys.exit(main())
