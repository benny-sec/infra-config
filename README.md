## basic environment set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/basic-infra-config.sh)"

## JDK 11.x set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh)"

## Atlassion Bamboo set-up
bash -c "$(wget -O- https://github.com/benny-sec/infra-config/blob/main/setup-bamboo.sh)"
