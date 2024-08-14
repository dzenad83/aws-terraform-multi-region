# Power Diary Assignment

## Terraform Backend Configuration


Since the assignment is about creating two environments in three different regions, I assumed that I should demonstrate how this small project could function within a larger ecosystem. Therefore, I laid out a complete folder structure to support this. For this approach, Terragrunt would be most suitable as it enables the reuse of existing configuration files in a hierarchy model. But I will leave that for an other discussion, since this would add on complexity at the moment.

```
The current folder structure supporting all environments and regions:

modules/
environments/
├── ap-southeast-2/
│   ├── test/
│   └── prod/
├── eu-west-2/
│   ├── test/
│   └── prod/
└── us-east-1/
    ├── test/
    └── prod/
```
Every environment will have it's own state! This is because we want to be able to do two things. To reuse existing modules as they are accross all environments, but add custom modules or custom configurations without affecting other environments in other regions.
