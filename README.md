# clinsoma-pip
An automated clinical grade Neztflow pipe line designed for somatic variant calling, quality control validation, and automated clinical tiering for targated NGS panels.
## Architecture and core features 
* **pipeline Orchestration:** Built using ** Nextflow (DSL2)** to ensure modularity, scalability, and built-in error handling across diverse compute environments
* **Automated Quality control:** Faetures a custom embedded python engine(bin/qc_automotar.py) that programmatically parses target depth and coverage metrics. IT dynamically flags runs falling below strict clinial diagnostic thresholds($>100\times$).
* **clinical Annotation Framework: ** Tailored to process somatic varaint calling files (VCFs from GATK Mutect2) and output structured JSON files prepared for downstream *AMP/ASCO/CAP** variant tiering classification.
  ---
pipeline directory structure 
```text
clinsoma-pip/
main.nf    # Nextflow core workflow pipeline logic
bin/       # Custom automated production scripts
qc_automator.py # pytho automated clincal depth/qc gatekeeper
README.md # pipeline documentation
