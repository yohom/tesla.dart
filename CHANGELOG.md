# Tesla.dart Changelog

## v0.4.0

- Helper library: Add support for `TESLA_CREDENTIALS_PATH` environment variable
  to specify a path to a JSON credentials file.

## v0.3.0

The v10 update!

- Support for triggering the HomeLink.
- Doors, frunk, and trunk open states are now available.
- Add `homelinkDeviceCount` getter to `VehicleState`.
- Add `isSmartSummonAvailable` getter to `VehicleState`.
- Add `centerDisplayActive` getter to `VehicleState`.
- Add `SummonVisualizationMessage` to allow drawing of the summon visualization.
- Add `SummonFindMeRequestMessage` that will allow summoning to a certain location.

## v0.2.0

- Drop support for Dart v1.x.x
- Add `setSentryMode` command, and support for `isSentryMode` getter.

## v0.1.2

- More reworking, cleans up code and minor improvements.

## v0.0.4

- Rework HTTP implementation to share code more.
- Allow using BASE64-encoded passwords for the standard tool API.
- Fix a bug with typing.

## v0.0.3

- Reorganize code to allow custom endpoints.
- Allow injecting API tokens.
- Rename `OptionCode` to `VehicleOptionCode`.
- Basic support for the browser (requires an API proxy).

## v0.0.2

- Abstract API and cleanup.
- Option code support.
- Support for software updates.
- Multi-platform support.

## v0.0.1

- Initial Version: No documentation.
