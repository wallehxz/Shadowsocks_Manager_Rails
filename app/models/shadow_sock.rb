# t.string   "local_path", limit: 255
# t.string   "server",     limit: 255
# t.integer  "timeout",    limit: 4
# t.string   "method",     limit: 255
# t.boolean  "fast_open"
# t.integer  "workers",    limit: 4
# t.datetime "created_at",             null: false
# t.datetime "updated_at",             null: false

class ShadowSock < ActiveRecord::Base
end
