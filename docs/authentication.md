# Accounts and API tokens

Simulation and verification require Run42 access and an Elan8 API token.
Create a token on your [Elan8 account](https://www.elan8.com/account?section=tokens),
then run:

```sh
run42 login
run42 license
```

The login prompt hides the token. `run42 license` reports the token source,
holder and signed-license expiry without printing credentials. A token alone
does not grant product access; your account must have Run42 enabled.

For automation, keep the token in your CI secret store and expose it as
`ELAN8_TOKEN` only to the step running Run42. An environment token takes
precedence over a saved token. Do not commit tokens or put them in examples.

Signed licenses normally refresh after 24 hours. Cached offline use ends at
the signed expiry, at most 48 hours after issuance and bounded by account access
and token expiry. Models and simulation results stay local; license retrieval
and refresh require network access.

`run42 logout` removes the saved token and cached licenses. If `ELAN8_TOKEN`
remains set, unset it separately. Help and version reporting need no token.
