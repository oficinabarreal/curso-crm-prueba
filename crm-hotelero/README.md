# crm-hotelero

CRM hotelero automatizado con Hermes IA para posadas en la cordillera

> **Customer Management** — Qualify → manage → watch-churn, with a CRM-store MCP and lifecycle memory.
>
> Generated with [`create-agent-harness`](https://github.com/ruvnet/agent-harness-generator). WASM kernel, multi-host support, witness-signed releases.

## Install

```bash
npm install -g crm-hotelero
crm-hotelero init
crm-hotelero doctor
```

## Agents

| Agent | Role |
|---|---|
| `lead-qualifier` | Scores and routes inbound leads. |
| `account-manager` | Owns the relationship and the next play. |
| `churn-watcher` | Detects and explains churn risk early. |

This harness ships with the **hermes** adapter.

## License

MIT
