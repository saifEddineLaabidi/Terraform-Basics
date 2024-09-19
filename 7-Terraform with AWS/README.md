# Introduction to IAM

aws iam help
aws --endpoint http://aws:4566 iam list-users
aws --endpoint http://aws:4566 iam create-user --user-name mary

Now that we have a few users created, let's grant them privileges.
Let's start with mary, grant her full administrator access by making use of the policy called AdministratorAccess.

aws --endpoint http://aws:4566 iam attach-user-policy --user-name mary --policy-arn arn:aws:iam::aws:policy/AdministratorAcces

aws --endpoint http://aws:4566 iam create-group --group-name project-sapphire-developers