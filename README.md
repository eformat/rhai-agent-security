= Securing AI Agents on Red Hat AI

*From OpenShell to Secure Agent Workspace.*

This Showroom workshop uses one OpenShift 4.22 cluster and combines the core
OpenShell/NemoClaw path with three supporting experiences:

* `automation/` contains the raw OpenShell harness and pinned policy used by
  Modules 1 and 2.
* `OpenShell` supplies the OpenShift Helm deployment, raw sandbox lifecycle, and
  default-deny/L7 policy exercises.
* `NemoClaw` supplies the managed OpenClaw runtime and policy model. The
  cluster-resident runtime is provisioned through Secure Agent Workspace rather
  than the standalone local `nemoclaw onboard` workflow.
* The `saw-emulation-fixes` branch of the `secure-agent-workspace` fork supplies
  the production-oriented deployment assets and the canonical SAW procedure.
* This repository provides the participant exercises, validation criteria, and
  technical context that connect those experiences.

* `agent-harness-in-a-box` supplies the raw OpenShift evaluation deployment and
  policy examples.
* `nemoclaw-openshift-launchable` remains useful context for interaction,
  configuration, observability, and fleet exercises, but its pinned versions
  are not the workshop baseline.

Build the site with:

```bash
npm ci
npm run build
```

The workshop includes the harness raw OpenShell deployment and policy
quickstart. It consumes the SAW deployment procedure directly from the fork's
Antora component so charts, scripts, and deployment commands are not copied into
this repository.
