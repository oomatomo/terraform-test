# terraform test

[terraform-example](https://github.com/terraform-providers/terraform-provider-aws/blob/master/examples/two-tier/main.tf)


## SetUp

[providers aws](https://www.terraform.io/docs/providers/aws/index.html)
```
brew install terraform

# バックアップで利用するS3のアクセスキーの設定
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="ap-northeast-1"

terraform init -backend-config="bucket=xxx"
```

## 実行

```
# 利用するアクセスキーなどの変数はこのリポジトリ外に置いてある
terraform plan -var-file=~/terraform.tfvars
terraform apply -var-file=~/terraform.tfvars
```
