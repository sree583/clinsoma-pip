#! /usr/bin/env nextflow
nextflow.enable.dsl=2
// Define pipeline parameters with default values
params.sample_id = "PANCREATIC_CA_001"
params.coverage =120
params.outdir = "results"
log.info """\
    CLINSOMA-PIP WORKFLOW
    ====================================
    Sample ID :${params.sample_id}
    MeanDepth :${params.coverage}X
    output Dir:${params.outdir}
    ====================================
    """
    .stripIndent()
// process 1: Automated quality control using your custom python script
process RUN_AUTOMATED_QC {
   publishDir"${params.outdir}/qc",mode: 'copy'
   input:
   val sample_id
   val coverage
   output:
   path"${sample_id}_qc_report.json",emit: qc_json
   script:
   """
   python3 qc_ automator.py --sample$  {sample_id} --coverage ${coverage}
   """
}
// Main workflow block coordinating execution 
workflow {
   //1. Initialize input data channel
   sample_ch = Channel.of (params.sample_id)
   coverage-ch= channel.of (params.coverage)
   // 2. Execute QC process
   RUN_AUTOMATED_QC(sample_ch,coverage_ch)
}
