package core

func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "FunisgoStreaming",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
			},
		},
		"options": map[string]any{
			"base": "https://api.funisgo.com",
			"auth": map[string]any{
				"prefix": "",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"channel": map[string]any{},
				"movie": map[string]any{},
				"series": map[string]any{},
			},
		},
		"entity": map[string]any{
			"channel": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "category",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "createdAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "description",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "id",
						"req": false,
						"type": "`$STRING`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "isLive",
						"req": false,
						"type": "`$BOOLEAN`",
						"index$": 4,
					},
					map[string]any{
						"active": true,
						"name": "isPremium",
						"req": false,
						"type": "`$BOOLEAN`",
						"index$": 5,
					},
					map[string]any{
						"active": true,
						"name": "language",
						"req": false,
						"type": "`$STRING`",
						"index$": 6,
					},
					map[string]any{
						"active": true,
						"name": "logoUrl",
						"req": false,
						"type": "`$STRING`",
						"index$": 7,
					},
					map[string]any{
						"active": true,
						"name": "name",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 8,
					},
					map[string]any{
						"active": true,
						"name": "streamUrl",
						"req": false,
						"type": "`$STRING`",
						"index$": 9,
					},
					map[string]any{
						"active": true,
						"name": "updatedAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 10,
					},
				},
				"name": "channel",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/channels",
								"parts": []any{
									"channels",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "category",
											"orig": "category",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"example": 20,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"reqd": false,
											"type": "`$INTEGER`",
										},
										map[string]any{
											"active": true,
											"example": 1,
											"kind": "query",
											"name": "page",
											"orig": "page",
											"reqd": false,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/channels",
								"parts": []any{
									"channels",
								},
								"select": map[string]any{
									"exist": []any{
										"category",
										"limit",
										"page",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "channel_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/channels/{channelId}",
								"parts": []any{
									"channels",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"channelId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "channel_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/channels/{channelId}",
								"parts": []any{
									"channels",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"channelId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "channel_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "PUT",
								"orig": "/channels/{channelId}",
								"parts": []any{
									"channels",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"channelId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"movie": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "createdAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "description",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "duration",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
						},
						"req": false,
						"type": "`$INTEGER`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "genre",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "id",
						"req": false,
						"type": "`$STRING`",
						"index$": 4,
					},
					map[string]any{
						"active": true,
						"name": "isPremium",
						"req": false,
						"type": "`$BOOLEAN`",
						"index$": 5,
					},
					map[string]any{
						"active": true,
						"name": "rating",
						"req": false,
						"type": "`$NUMBER`",
						"index$": 6,
					},
					map[string]any{
						"active": true,
						"name": "releaseYear",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
						},
						"req": false,
						"type": "`$INTEGER`",
						"index$": 7,
					},
					map[string]any{
						"active": true,
						"name": "streamUrl",
						"req": false,
						"type": "`$STRING`",
						"index$": 8,
					},
					map[string]any{
						"active": true,
						"name": "thumbnailUrl",
						"req": false,
						"type": "`$STRING`",
						"index$": 9,
					},
					map[string]any{
						"active": true,
						"name": "title",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 10,
					},
					map[string]any{
						"active": true,
						"name": "updatedAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 11,
					},
				},
				"name": "movie",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/movies",
								"parts": []any{
									"movies",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "genre",
											"orig": "genre",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"example": 20,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"reqd": false,
											"type": "`$INTEGER`",
										},
										map[string]any{
											"active": true,
											"example": 1,
											"kind": "query",
											"name": "page",
											"orig": "page",
											"reqd": false,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/movies",
								"parts": []any{
									"movies",
								},
								"select": map[string]any{
									"exist": []any{
										"genre",
										"limit",
										"page",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "movie_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/movies/{movieId}",
								"parts": []any{
									"movies",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"movieId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "movie_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/movies/{movieId}",
								"parts": []any{
									"movies",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"movieId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "movie_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "PUT",
								"orig": "/movies/{movieId}",
								"parts": []any{
									"movies",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"movieId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"series": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "createdAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "description",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "episodes",
						"req": false,
						"type": "`$INTEGER`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "genre",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "id",
						"req": false,
						"type": "`$STRING`",
						"index$": 4,
					},
					map[string]any{
						"active": true,
						"name": "isPremium",
						"req": false,
						"type": "`$BOOLEAN`",
						"index$": 5,
					},
					map[string]any{
						"active": true,
						"name": "rating",
						"req": false,
						"type": "`$NUMBER`",
						"index$": 6,
					},
					map[string]any{
						"active": true,
						"name": "releaseYear",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$INTEGER`",
							},
						},
						"req": false,
						"type": "`$INTEGER`",
						"index$": 7,
					},
					map[string]any{
						"active": true,
						"name": "seasons",
						"req": false,
						"type": "`$INTEGER`",
						"index$": 8,
					},
					map[string]any{
						"active": true,
						"name": "thumbnailUrl",
						"req": false,
						"type": "`$STRING`",
						"index$": 9,
					},
					map[string]any{
						"active": true,
						"name": "title",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 10,
					},
					map[string]any{
						"active": true,
						"name": "updatedAt",
						"req": false,
						"type": "`$STRING`",
						"index$": 11,
					},
				},
				"name": "series",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/series",
								"parts": []any{
									"series",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "genre",
											"orig": "genre",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"example": 20,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"reqd": false,
											"type": "`$INTEGER`",
										},
										map[string]any{
											"active": true,
											"example": 1,
											"kind": "query",
											"name": "page",
											"orig": "page",
											"reqd": false,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/series",
								"parts": []any{
									"series",
								},
								"select": map[string]any{
									"exist": []any{
										"genre",
										"limit",
										"page",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "series_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/series/{seriesId}",
								"parts": []any{
									"series",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"seriesId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "series_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/series/{seriesId}",
								"parts": []any{
									"series",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"seriesId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"kind": "param",
											"name": "id",
											"orig": "series_id",
											"reqd": true,
											"type": "`$STRING`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "PUT",
								"orig": "/series/{seriesId}",
								"parts": []any{
									"series",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"seriesId": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"index$": 0,
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
