local clusterName = 'staging.openmedia',
      k8sServiceHost = 'localhost',

      argoCDSourceRepo = 'https://github.com/archisman-mridha/dotfiles';

(import 'cloudnative-pg.libsonnet') +
(import 'dragonfly.libsonnet') +

// Networking and Ingress related.
(import 'cilium.libsonnet')(k8sServiceHost) +

// Monitoring related.
(import 'node-problem-detector.libsonnet') +
(import 'kube-prometheus-stack.libsonnet') +

// Security related.
(import 'kubearmor.libsonnet') +
(import 'kyverno.libsonnet') +

// GitOps related.
(import 'argo-cd.libsonnet')(argoCDSourceRepo) +
(import 'sealed-secrets.libsonnet') +
(import 'crossplane.libsonnet') +

// Self hosted alternatives to paid applications.
(import 'harbor.libsonnet')
