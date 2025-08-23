Incident Note – Liquibase CI/CD Pipeline Failure for DCV Application

Incident ID: INC12348750
Impacted User: Rama Rao Palacherla

During the implementation of the Liquibase database CI/CD pipeline for the DCV application, the pipeline failed because Illumio blocked the request to the DCV production database servers:

RT14A10270PV00.BNYMELLON.NET (TPC)

RC14A10346PV00.BNYMELLON.NET (CNJ)

We attempted to retrieve the blocked source IP using the Illumio self-service dashboard, but the mnemonic DCV is under audit control and cannot be checked through the platform. Support from Illumio Production Services is required to provide the blocked source IP (failure occurred on 2025-08-22 22:50:18).