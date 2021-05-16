include { DOWNLOAD_CARNEIRO } from "./workflows/download_genomes/carneiro.nf" addParams (resultsDir: "${params.outdir}/raw/carneiro")


workflow DOWNLOAD_GENOMES {
    DOWNLOAD_CARNEIRO()
}
