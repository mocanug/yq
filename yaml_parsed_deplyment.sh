#!/usr/bin/env bash

echo "Installing scripts used for yaml parsing and json-yaml/yaml-json transformation"
echo "The jq must be installed and the python3 scripts require installation of the pyyaml library."
echo "If a debian based distro is used and python3-yaml version is above 5.1 use: 'apt-get install python3-yaml'"
echo "or using pip: 'pip3 install pyyaml' or 'pip3 install -r requirements.txt'"
sleep 3
clear

echo "Add script to convert from yaml to json: yaml2json"
sleep 2
clear

cat << _EOF > /usr/local/bin/yaml2json
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
_EOF

chmod 755 /usr/local/bin/yaml2json

echo "Add script to convert from json to yaml: json2yaml"
sleep 2
clear

cat << _EOF > /usr/local/bin/json2yaml
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
_EOF

chmod 755 /usr/local/bin/json2yaml

echo "Add script to filter json input using jq and convert output to yaml: jqy"
sleep 2
clear

cat << _EOF > /usr/local/bin/jqy
#!/usr/bin/env bash

if [[ "\${*}x" == "x" ]]
then
    jq . | json2yaml
else
    jq \${*} | json2yaml
fi

_EOF

chmod 755 /usr/local/bin/jqy

echo "Add script to filter yaml input using jq after the json conversion and output to yaml: yq"
sleep 2
clear

cat << _EOF > /usr/local/bin/yq
#!/usr/bin/env bash

if [[ "\${*}x" == "x" ]]
then
    yaml2json | jq . | json2yaml
else
    yaml2json | jq \${*} | json2yaml
fi
_EOF

chmod 755 /usr/local/bin/yq

echo "Please remember that the jq must be installed and the python3 scripts require installation of the pyyaml library."
echo "If a debian based distro is used and python3-yaml version is above 5.1 use: 'apt-get install python3-yaml'"
echo "or using pip: 'pip3 install pyyaml' or 'pip3 install -r requirements.txt'"
sleep 2
clear
echo "Deployment complete"