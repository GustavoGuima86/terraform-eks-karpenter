locals {
  name                                         = "ex-${basename(path.cwd)}"
  SSO_AdministratorAccess_role                 = tolist(data.aws_iam_roles.SSO_AdministratorAccess_role.arns)[0]
}
