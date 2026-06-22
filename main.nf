#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Define pipeline parameters
params.sample_id = "PANCREATIC_CA_001"
params.coverage  = 120
params.outdir    = "results"

// Process block for running the script
process RUN_AUTOMATED_QC {
    publishDir "${params.outdir}/qc", mode: 'copy'

    input:
    val sample_id
    val coverage

    output:
    path "${sample_id}_qc_report.json"

    script:
    """
    python3 ${projectDir}/bin/qc_automator.py --sample ${sample_id} --coverage ${coverage}
    """
}

// Main workflow execution block
workflow {
    sample_ch = Channel.of(params.sample_id)
    coverage_ch = Channel.of(params.coverage)

    RUN_AUTOMATED_QC(sample_ch, coverage_ch)
}
