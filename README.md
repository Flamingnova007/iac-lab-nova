# iac-lab-nova

Practice repository for Infrastructure as Code on Azure: a modular Bicep foundation, a complementary Terraform component, and drift handling.

## Purpose
Holds the code for deploying a small Azure foundation with Bicep and one extra component with Terraform, plus the notes needed to review and reproduce each deployment.

## Prerequisites
- Azure CLI with Bicep installed
- Terraform 1.x
- Git
- Contributor access to an Azure resource group

## Repository layout (planned)
- `bicep/` main file, parameter file and `modules/`
- `terraform/` configuration for the complementary component
- `docs/` diagrams and plan output files

## How to deploy
Commands are added together with the code.

## Naming and tags
Resources use the `arsh-<resource>` prefix and carry the tags `Owner=Arsh` and `Week=9`.

## Branching and contributing
- `main` is protected and changes arrive only through a pull request.
- Work happens on `feature/<topic>` or `fix/<topic>` branches.
- A pull request needs one approving review and includes the what-if or plan output.
- Commit messages are short and imperative, for example "Add NSG module".
- No secrets, subscription IDs or tenant IDs are committed.

## Owner
Arsh
