process CollectInsertSizeMetrics {
    publishDir params.collectInsertSizeMetricsResultsDir, mode: params.saveMode
    container "quay.io/biocontainers/picard:2.23.4--0"

    when:
    params.collectInsertSizeMetrics

    input:
    file(dedupedSortedBamFile) from ch_in_collectInsertSizeMetrics

    output:
    tuple file("*.txt"),
            file("*pdf") into ch_out_collectInsertSizeMetrics


    script:

    """
    picard CollectInsertSizeMetrics INPUT=${dedupedSortedBamFile}  OUTPUT=${refFastaName}_insert_metrics.txt HISTOGRAM_FILE=${dedupedSortedBamFile}_insert_size_histogram.pdf
    """
}
