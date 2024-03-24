function outcell = cellwise_inbetween(from_cell, to_cell, factor)

outcell = cellfun(@(from_val, to_val) from_val - (from_val-to_val)*factor, ...
                  from_cell, to_cell, "UniformOutput",false);

end