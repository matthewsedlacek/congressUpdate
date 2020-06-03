class Congressperson < ActiveRecord::Base
    def resolve_name
        start = candidate_name
        start = start.split(" ").map(&:capitalize).join(" ")
        last, rest = start.split(", ")
        candidate_name + "  converts to: " + [rest.split[0], last].join("_")
    end
end