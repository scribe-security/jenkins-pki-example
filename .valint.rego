package verify
import data.superset.policy as policy

default allow = false

allow  {
  policy.cve.allow
  # policy.images.allow
  # policy.licences.allow
  # policy.unmaintained.allow
}

errors = [
  policy.cve.errors,
  # policy.images.errors,
  # policy.licences.errors,
  # policy.unmaintained.errors,
]

violations = [
  policy.cve.violations,
  # policy.images.violations,
  # policy.licences.violations,
  # policy.unmaintained.violations,
]

summary = [
  policy.cve.summary,
  # policy.images.summary,
  # policy.licences.summary,
  # policy.unmaintained.summary,
]


verify = v {
        v := {
        "allow": allow,
        "violations": violations,
        "summary": summary,
    }
}
