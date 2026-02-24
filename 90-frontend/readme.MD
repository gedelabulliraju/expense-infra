# Expense Architecture

![alt text](expense-infra-dev.drawio.svg)

# Terraform: Taint

**Purpose:** 

Tainting a resource marks it for recreation during the next terraform apply operation. This is useful when you want to forcefully destroy and recreate a resource without changing its configuration.

Command: You can taint a resource using:

```bash
terraform taint <resource>
```

**Effect:** 

The resource will be destroyed and then recreated, even if there are no configuration changes. This can be useful when a resource becomes corrupted or you want to trigger a fresh start for it.

**Dependency Impact:** 

When you taint a resource that has dependencies (other resources rely on it), those dependent resources might not be destroyed and recreated unless their configuration explicitly changes as a result of the tainted resource being recreated. Terraform will maintain the dependency order but will only recreate the tainted resource unless other dependent resources are also affected indirectly.

# Terraform: Target

**Purpose:** 

The -target flag is used to apply or destroy only specific resources in a Terraform configuration, bypassing others.

Command: You can specify a target using:

```bash
terraform apply -target=<resource>
```
**Effect:** 

Terraform will only manage the targeted resource and ignore others during the plan and apply phases. This can be useful when you are debugging or deploying just a part of your infrastructure.

**Dependency Impact:** 

This is where it gets tricky. When you use -target on a resource that has dependencies, Terraform might not properly handle the dependent resources. If the target resource depends on something else or has resources depending on it, those dependencies may be missed, leading to a broken or incomplete state.

**NOTE:** Even you target a specific resource terraform will still evaluate the desired infra and actual infra.

**Best Practices:**
Use taint cautiously when you need to recreate a resource and want to ensure that all its dependencies are also properly handled by Terraform.
Avoid using -target in production for complex infrastructures with multiple dependencies. It can break dependency chains and lead to an inconsistent state. It's more suited for debugging or when you know for sure that focusing on a specific resource won't affect others.
If you have a complex dependency structure, it's usually better to let Terraform handle the entire graph of resources instead of trying to target specific ones.