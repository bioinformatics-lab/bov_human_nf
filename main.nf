nextflow.enable.dsl = 2


include { TRIMMOMATIC } from "./modules/trimmomatic/trimmomatic.nf"
include { FASTQC as FASTQC_UNTRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_untrimmed")
include { FASTQC as FASTQC_TRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_TRIMMED } from "./modules/multiqc/multiqc.nf" addParams(resultsDir: "${params.outdir}/multiqc_trimmed", fastqcResultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_UNTRIMMED } from "./modules/multiqc/multiqc.nf" addParams(resultsDir: "${params.outdir}/multiqc_untrimmed", fastqcResultsDir: "${params.outdir}/fastqc_untrimmed")
include { MTBSEQ_PER_SAMPLE; MTBSEQ_COHORT } from "./modules/mtbseq/mtbseq.nf"
include { SPOTYPING } from "./modules/spotyping/spotyping.nf"
include { UTILS_FILTER_CONTIGS } from "./modules/utils/filter_contigs/filter_contigs.nf"
include { QUAST } from "./modules/quast/quast.nf"
include { SPADES } from "./modules/spades/spades.nf"

workflow {
    reads_ch = Channel.fromFilePairs(params.reads)
    gatk38_jar_ch = Channel.value(java.nio.file.Paths.get("$params.gatk38_jar"))
    env_user_ch = Channel.value("root")
    referenceFasta_ch = Channel.value(java.nio.file.Paths.get(params.referenceFasta))

    // STEP-1
    // FASTQC_UNTRIMMED(reads_ch)
    // MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out.flatten().collect())
    TRIMMOMATIC(reads_ch)
    // FASTQC_TRIMMED(TRIMMOMATIC.out)
    // MULTIQC_TRIMMED(FASTQC_TRIMMED.out.flatten().collect())
    // SPOTYPING(TRIMMOMATIC.out)


    // STEP-2
    SPADES(TRIMMOMATIC.out)
    UTILS_FILTER_CONTIGS(SPADES.out[0])
    QUAST(UTILS_FILTER_CONTIGS.out.collect(), referenceFasta_ch)


    // STEP-3
    // MTBSEQ_PER_SAMPLE(TRIMMOMATIC.out,
    //         gatk38_jar_ch,
    //         env_user_ch)


    // samples_tsv_file_ch = MTBSEQ_PER_SAMPLE.out[0]
    //         .collect()
    //         .flatten().map { n -> "$n" + "\t" + "$params.mtbseq_library_name" + "\n" }
    //         .collectFile(name: 'samples.tsv', newLine: false, storeDir: "$params.resultsDir_mtbseq_cohort")

    // MTBSEQ_COHORT(
    //         samples_tsv_file_ch,
    //         MTBSEQ_PER_SAMPLE.out[2].collect(),
    //         MTBSEQ_PER_SAMPLE.out[3].collect(),
    //         gatk38_jar_ch,
    //         env_user_ch,
    // )


}


// include { DOWNLOAD_CARNEIRO } from "./workflows/download_genomes/carneiro.nf" addParams (resultsDir: "${params.outdir}/raw/carneiro")
// workflow DOWNLOAD_GENOMES {
//     DOWNLOAD_CARNEIRO()
// }
