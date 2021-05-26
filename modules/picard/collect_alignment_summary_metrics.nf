process CollectAlignmentSummaryMetrics {
    publishDir params.collectAlignmentSummaryMetricsResultsDir, mode: params.saveMode
    container "quay.io/biocontainers/picard:2.23.4--0"

    when:
    params.collectAlignmentSummaryMetrics

    input:
    path refFasta from ch_refFasta
    file(dedupedSortedBamFile) from ch_in_collectAlignmentSummaryMetrics

    output:
    file "*.txt" into ch_out_collectAlignmentSummaryMetrics


    script:
    refFastaName = refFasta.toString().split("\\.")[0]

    """
    picard CollectAlignmentSummaryMetrics R=${refFasta} I=${dedupedSortedBamFile}  O=${refFastaName}_alignment_metrics.txt
    """
}
