# PACIO SMP Test Kit Test Kit

This is an [Inferno](https://github.com/inferno-community/inferno-core) Test Kit
for PACIO SMP Implementation Guide
[v1.0.0](https://hl7.org/fhir/us/smp/STU1/)

PACIO SMP test kit [Inferno](https://github.com/inferno-community/inferno-core) Test Kit
for FHIR testing.

## Getting Started

The quickest way to run this test kit locally is with [Docker](https://www.docker.com/).

- Install [Docker](https://www.docker.com/). 

- Clone this repository. 
  ```
  git clone https://github.com/paciowg/pacio-smp-test-kit.git
  ```
  or
  ```
  git clone git@github.com:paciowg/pacio-smp-test-kit.git
  ```

- **Temporary step:** Switch to the `generator` branch for the latest updates:
  ```
  git checkout connectathon-2026-01
  ```

### Running the Test Kit

- Run `./setup.sh` in the test kit directory to download and install all required dependencies  
  *(e.g., Inferno modules, Ruby gems, configuration files).*

- Run `./run.sh` in the test kit directory to start the Inferno application.  
  After launch, you should see a message indicating that the server is running.

- Open a browser and navigate to `http://localhost`.

  > If the page does not load, confirm that Docker is running and the `run.sh` script completed successfully.

- In the **Test Suites** list, select **PACIO SMP Test Kit v1.0.0**, then click the **SELECT SUITE** button.

- On the **PACIO SMP Server v1.0.0** Inferno test suite page, click the **RUN ALL TESTS** tab in the top-right corner.

- When the parameter dialog appears, enter the following configuration values:

  - **FHIR Endpoint (required):**  
    The base URL where FHIR data are accessible.

  - **OAuth Credentials (optional):**  
    The PACIO SMP test kit does *not* support SMART App Launch.  
    If the server requires an access token, provide it so Inferno can read FHIR resources.

  - **Patient IDs (required):**  
    One or more Patient resource IDs, separated by commas.

  - **FHIR Parameter resources for `$smp-query` and `$smp-submit` (optional):**  
    These operations are not required to be supported by the server.  
    If Parameter resources are provided:
    - Inferno will send operation requests with the supplied parameter values.
    - Inferno will confirm whether the server accepts the request and returns a valid response.

  - **Bundle IDs (optional):**  
    One or more Bundle resource IDs, separated by commas.  
    These inputs are optional because the **Bundle Medication List** and **Bundle Medication List Maintenance** profiles are *not* required by the SMP IG.  
    If IDs are supplied, Inferno will:
    - attempt to read the Bundle resources  
    - validate conformance to the appropriate Bundle profiles

- Click **SUBMIT** in the bottom-right corner to begin Inferno testing.

- Testing may take several minutes depending on:
  - the number of resources returned by the server,
  - server performance,
  - network speed.

  A progress bar and test-by-test output will appear during execution.



## Instructions for Developing Your Test Kit

Refer to the Inferno documentation for information about [setting up
your development environment and running your Test Kit](https://inferno-framework.github.io/docs/getting-started/).

More information about what is included in this repository can be [found here](https://inferno-framework.github.io/docs/getting-started/repo-layout-and-organization.html).

## Documentation
- [Inferno documentation](https://inferno-framework.github.io/docs/)
- [Ruby API documentation](https://inferno-framework.github.io/inferno-core/docs/)
- [JSON API documentation](https://inferno-framework.github.io/inferno-core/api-docs/)

## Example Inferno Test Kits

A list of all Test Kits registered with the Inferno Team can be found on the [Test Kit Registry](https://inferno-framework.github.io/community/test-kits.html) page.

## License
Copyright 2025 TODO

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at
```
http://www.apache.org/licenses/LICENSE-2.0
```
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
