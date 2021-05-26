// nextflow.enable.dsl = 2

// process CARNEIRO {
//     tag "${genomeId}"
//     errorStrategy "ignore"
//     cpus 1
//     publishDir params.resultsDir, mode: 'move'

//     input:
//     val(genomeId)

//     output:
//     path("*fa")

//     script:
//     """
//     ncbi-acc-download --format fasta ${genomeId}

//     """
// }

// workflow DOWNLOAD_CARNEIRO {

//     sra_ch = Channel.of(ids)

//     CARNEIRO(sra_ch.flatten())

// }


/*
================================
params
================================
*/

params.resultsDir = 'results/rawGenomes'
params.apiKey = "FIXME"

/*
================================
ids of genomes to be downloaded
================================
*/

ids = [
"ERX4391447",
"ERX4391472",
"ERX4391425",
"ERX4391462",
"ERX4391473",
"ERX4391686",
"ERX4391451",
"ERX4391429",
"ERX4391432",
"ERX4391452",
"ERX4391460",
"ERX4391698",
"ERX4391422",
"ERX4391427",
"ERX4391436",
"ERX4391444",
"ERX4391455",
"ERX4391454",
"ERX4391695",
"ERX4391467",
"ERX4391475",
"ERX4391453",
"ERX4391434",
"ERX4391692",
"ERX4391428",
"ERX4391458",
"ERX4391687",
"ERX4391469",
"ERX4391688",
"ERX4391450",
"ERX4391426",
"ERX4391457",
"ERX4391441",
"ERX4391443",
"ERX4391449",
"ERX4391424",
"ERX4391438",
"ERX4391470",
"ERX4391465",
"ERX4391693",
"ERX4391463",
"ERX4391685",
"ERX4391446",
"ERX4391459",
"ERX4391683",
"ERX4391439",
"ERX4391697",
"ERX4391476",
"ERX4391479",
"ERX4391440",
"ERX4391437",
"ERX4391431",
"ERX4391442",
"ERX4391433",
"ERX4391691",
"ERX4391423",
"ERX4391461",
"ERX4391471",
"ERX4391694",
"ERX4391456",
"ERX4391477",
"ERX4391466",
"ERX4391474",
"ERX4391468",
"ERX4391445",
"ERX4391684",
"ERX4391689",
"ERX4391448",
"ERX4391690",
"ERX4391435",
"ERX4391430",
"ERX4391478",
"ERX4391464",
"ERX4391696"

    ]



/*
================================
only for publishing these files to results folder
================================
*/


process downloadRawGenomes {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: 'copy'

    input:
    tuple val(genomeName), path(genomeReads) from Channel.fromSRA(ids, cache: true, apiKey: params.apiKey)

    script:

    """
    echo ${genomeName}
    echo ${genomeReads[0]}
    echo ${genomeReads[1]}
    """

    //mkdir -p ../../../$params.resultsDir
    //cp \$(readlink -f ${genomeReads[0]}) ../../../$params.resultsDir/
    //cp \$(readlink -f ${genomeReads[1]}) ../../../$params.resultsDir/


}
