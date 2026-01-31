# CarSpa Gross Profit Extension

Business Central-extension som viser bruttofortjeneste per linje og totalt på salgsordrer og tilbud.

## Funksjonalitet

- Bruttofortjeneste (kroner og %) per varelinje på ordrer og tilbud
- Factbox med total kostpris, utsalgspris, bruttofortjeneste og margin %
- Factbox på ordreliste og tilbudsliste (beregner kun for valgt dokument)

## Oppsett

### Forutsetninger

- Visual Studio Code
- [AL Language-extension](https://marketplace.visualstudio.com/items?itemName=ms-dynamics-smb.al) (Microsoft)

### Konfigurasjon

#### launch.json

Filen `.vscode/launch.json` inneholder to konfigurasjoner. Velg aktiv konfigurasjon i VS Code debugger-panelet (dropdown øverst):

| Konfigurasjon | Bruk |
|---|---|
| **CarSpa - Production** | Produksjonsmiljøet. Bruk `AL: Package` for å bygge .app-filen, og last opp via Extension Management i BC. |
| **CarSpa - Sandbox** | Utviklingsmiljø. Bruk `F5` for å deploye og teste direkte. |

**Viktig:** Ikke bruk `F5` mot Production-konfigurasjonen. Bygg med `AL: Package` og last opp .app-filen manuelt.

Hvis du trenger å endre miljønavn eller tenant, oppdater disse feltene i `.vscode/launch.json`:

```json
"environmentName": "Ditt_Miljønavn",
"tenant": "din-tenant-id"
```

#### app.json

| Felt | Beskrivelse | Endre ved behov |
|---|---|---|
| `version` | Bump ved hver ny release | Ja |
| `application` | BC-applikasjonsversjon (nå `27.0.0.0`) | Ja, ved BC-oppgradering |
| `runtime` | AL runtime-versjon (nå `16.0`) | Ja, ved BC-oppgradering |
| `resourceExposurePolicy` | Nå satt for prod (kildekode skjult) | Sett `allowDownloadingSource: true` for debugging i sandbox |

## Deployment

### Sandbox

```
F5 i VS Code (velg "CarSpa - Sandbox")
```

### Produksjon

1. Velg "CarSpa - Production" i debugger-dropdown (for riktig symbolnedlasting)
2. Command palette (`Cmd+Shift+P`) → `AL: Package`
3. Last opp den genererte `.app`-filen via **Extension Management** i produksjonsmiljøet i BC
4. Bump `version` i `app.json` før neste release
