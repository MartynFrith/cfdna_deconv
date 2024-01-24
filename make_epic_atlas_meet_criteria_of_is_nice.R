library(dplyr)
library(GenomicRanges)

### Some of the blocks in the epic atlas overlap with each other, which is stopping the deconvolution program from progressing 

atlas <-read.delim("build_atlas_out/Atlas.EPIC.U250.l4.hg38.full.tsv", header = T)


atlas_neu_only <- dplyr::filter(atlas, target == "Neuron")
find_overlaps_neu <- makeGRangesFromDataFrame(atlas_neu_only, seqnames.field="chr",
                                              start.field="start",
                                              end.field="end")

find_overlaps_else <- dplyr::filter(atlas, target != "Neuron")
find_overlaps_else <- makeGRangesFromDataFrame(find_overlaps_else, seqnames.field="chr",
                                               start.field="start",
                                               end.field="end")
ov <- countOverlaps(find_overlaps_neu, find_overlaps_neu)
ov_true <- which(ov == 2)
ov_true <- ov_true[c(T,F)]

atlas_neu_only_overlaps_removed <- atlas_neu_only[-ov_true, ]
atlas <- filter(atlas, target != "Neuron")
atlas <- rbind(atlas, atlas_neu_only_overlaps_removed)
atlas <- arrange_(atlas, "startCpG", descending = T)
write.table(atlas, file = "build_atlas_out/Atlas.EPIC.U250.l4.hg38.full.nice.tsv", sep = '\t', col.names = T, row.names = F, quote = F)
