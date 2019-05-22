package shard

import (
	"hash/fnv"
	"github.com/hyperledger/fabric/core/peer"
)

func KeyHash(key string) uint32 {
        h := fnv.New32a()
        h.Write([]byte(key))
        return h.Sum32()
}

func GetShardIdForKey(key string) (uint32) {
	var shards, _ = peer.GetShardsCount()	
	if shards != 0 {
		// return KeyHash(key) % shards
		return uint32(key[0]) % shards
	}
	return 0
}

func GetShardMatch(key string) (bool) {
	var shards, _ = peer.GetShardsCount()
	var shardId, _ = peer.GetShardId()
	if shards != 0 {
		return GetShardIdForKey(key) == shardId
	}
	return true
}