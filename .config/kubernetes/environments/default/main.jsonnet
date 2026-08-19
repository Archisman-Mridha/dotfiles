local clusterName = 'staging.openmedia',
      k8sServiceHost = 'localhost',

      argoCDSourceRepo = 'https://github.com/archisman-mridha/dotfiles';

// Networking and Ingress related.
(import 'cilium.libsonnet')(k8sServiceHost) +

// For monitoring.
(import 'node-problem-detector.libsonnet') +
(import 'kube-prometheus-stack.libsonnet') +

// For security.
(import 'kubearmor.libsonnet') +
(import 'kyverno.libsonnet') +

// For GitOps.
(import 'argo-cd.libsonnet')(argoCDSourceRepo) +
(import 'sealed-secrets.libsonnet') +

// Miscellaneous.

(import 'crossplane.libsonnet') +

(import 'cloudnative-pg.libsonnet')
