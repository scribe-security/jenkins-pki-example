package verify
import data.superset.policy as policy
default allow = false

verify = v {
  v := {
    "allow": allow,
    "violation": violation,
    "errors": errors,
    "summary": summary,
  }
}

allow  {
  policy.unmaintained.allow
  policy.cve.allow
  policy.images.allow
  policy.licences.allow
}

errors[msg] {
  msg := policy.unmaintained.errors[_]
}

errors[msg] {
  msg := policy.cve.errors[_]
}

errors[msg] {
  msg := policy.images.errors[_]
}

errors[msg] {
  msg := policy.licences.errors[_]
}

violation[msg] {
  msg := policy.unmaintained.violation[_]
}

violation[msg] {
  msg := policy.cve.violation[_]
}

violation[msg] {
  msg := policy.images.violation[_]
}

violation[msg] {
  msg := policy.licences.violation[_]
}

summary[msg] {
  msg := policy.unmaintained.summary[_]
}

summary[msg] {
  msg := policy.cve.summary[_]
}

summary[msg] {
  msg := policy.images.summary[_]
}

summary[msg] {
  msg := policy.licences.summary[_]
}
