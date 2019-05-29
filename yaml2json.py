#!/usr/bin/env python3

import sys
import json
import yaml


def main():
    # read multiline input
    std_input = ""
    while True:
        try:
            line = input()
        except EOFError:
            break
        std_input = "{}\n{}".format(std_input, line)

    try:
        yaml_in = yaml.load(std_input, Loader=yaml.FullLoader)
        print(json.dumps(yaml_in))
    except yaml.YAMLError as e:
        print("No valid yaml input: {}".format(e.msg))
    except Exception as e:
        print("Error: {}".format(e.msg))


if __name__ == '__main__':
    sys.exit(main())
