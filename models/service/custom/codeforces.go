package custom

import (
	spiderservice "github.com/l-dandelion/yi-ants-web/models/service/spider"
	"fmt"
	"strings"
)

var ruleStr = `{
"kind": "mysql",
"tableName": "cfrank_%s",
"node": "array|body",
"user_rank": "text|#pageContent > div:nth-child(3) > div.userbox > div.info > div > div.user-rank > span",
"name": "text|#pageContent > div:nth-child(3) > div.userbox > div.info > div > h1 > a",
"rating": "text|#pageContent > div:nth-child(3) > div.userbox > div.info > ul > li:nth-child(1) > span"
}`

func GenCodeforcesModel(name, usernames string) *spiderservice.Model {
	parserModel := &spiderservice.ParserModel{
		Type:"template",
		Rule:fmt.Sprintf(ruleStr, name),
	}
	processModel := &spiderservice.ProcessorModel{
		Type:"mysql",
	}
	model := &spiderservice.Model{
		Name: name,
		Depth: "0",
		Domains: "codeforce.com",
		ParserModels: []*spiderservice.ParserModel{parserModel},
		ProcessorModels: []*spiderservice.ProcessorModel{processModel},
		Urls:fmt.Sprintf("http://codeforces.com/profile/{%s}", strings.TrimSpace(usernames)),
	}
	return model
}