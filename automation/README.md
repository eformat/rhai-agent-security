= Workshop Automation

This directory contains the OpenShift OpenShell evaluation installer and the
canonical policy used by the workshop.

Secure Agent Workspace deployment assets are not copied into this directory.
Follow the workshop instructions from the `saw-emulation-fixes` branch of the
`taylorjordanNC/secure-agent-workspace` fork.

== Prerequisites

Run from a RHEL/Fedora bastion or a validated Linux/WSL2 environment:

* OpenShift 4.22 access with the permissions required by the selected install.
* `oc`, Helm 3, OpenShell `0.0.103`, `jq`, `make`, `curl`, and `openssl`.
* `virtctl` matching the cluster for SAW VM inspection and SSH.

Install the pinned OpenShell client with:

[source,bash]
----
./automation/bootstrap/install-openshell-cli.sh
----

Check the local tools and cluster context:

[source,bash]
----
make -C automation prerequisites
----

== Raw OpenShell

Install the harness-compatible evaluation gateway, then run the sandbox
control-layer test after the Modules 1-2 exercises have created the
`policy-lab` sandbox and applied the quickstart policy:

[source,bash]
----
make -C automation install-openshell
make -C automation openshell-security-test
----

This path intentionally uses the harness's plaintext, unauthenticated lab
configuration. It is not the production security posture.

== Update the pinned baseline

The OpenShell version and the default sandbox image digest are pinned in
several places. Update all of them in a single commit so the automation,
content, and verification cannot drift:

[cols="1,2",options="header"]
|===
| Location | What to update

| `automation/Makefile`
| `OPENSHELL_VERSION` (Helm chart and CLI pin) and `OPENSHELL_SANDBOX_IMAGE`
  (default sandbox image digest)

| `content/antora.yml`
| `openshell_version` and `openshell_sandbox_image` (rendered into the
  participant pages)

| `secure-agent-workspace/docs/antora/antora.yml` (SAW fork)
| `openshell_version`, `openshell_saw_version`, and `ocp_version` must agree
  with this repository; `npm run validate:docs` enforces the parity

| `automation/harness/01-basic-openshell/verify.sh`
| The `OPENSHELL_VERSION` fallback default used when the script runs outside
  `make openshell-verify`

| `automation/README.md` and
  `automation/harness/01-basic-openshell/README.md`
| The pinned version named in the prerequisites text
|===

After updating, run `make -C automation openshell-verify` and
`npm run validate:docs` from the repository root, then commit the change as one
commit.

The SAW guest gateway pin (`openshell_saw_version`) is a Red Hat packaging
suffix of the same compatibility line; update it only when the SAW fork changes
its gateway build.
