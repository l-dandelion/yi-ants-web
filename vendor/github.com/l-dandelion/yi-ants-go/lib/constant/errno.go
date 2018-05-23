package constant

const (
	/*
	 * common error
	 * 通用错误
	 */

	//args error(参数错误)
	ERR_ARGS = 10001
	//read file fail
	ERR_READ_FILE = 10002
	//gen func
	ERR_FUNC_GEN = 10003

	/*
	 * crawl error
	 * 抓取错误
	 */
	//downloader error(下载器错误)
	ERR_CRAWL_DOWNLOADER = 20001
	//analyzer error(分析器错误)
	ERR_CRAWL_ANALYZER = 20002
	//pipeline error(条目处理器错误)
	ERR_CRAWL_PIPELINE = 20003
	//scheduler error(调度器错误)
	ERR_CRAWL_SCHEDULER = 20004
	//get dom fail
	ERR_CRAWL_GET_DOM = 20005
	//get complate url fail
	ERR_CRAWL_GET_COMPLATE_URL = 20006
	//new http request fail
	ERR_CRAWL_NEW_HTTP_REQUEST = 20007

	/*
	 * module error
	 */

	//not found module instance(未找到组件实例)
	ERR_MODULE_NOT_FOUND = 30001
	//generate MID error(生成MID错误)
	ERR_GENERATE_MID = 30002
	//split mid error(拆解mid错误)
	ERR_SPLIT_MID = 30003
	//new address error(新建address错误)
	ERR_NEW_ADDRESS = 30004
	//register module error(注册module错误)
	ERR_REGISTER_MODULE = 30005
	//illegal module type(非法组件类型)
	ERR_ILLEGAL_MODULE_TYPE = 30006
	//new downloader error(新建下载器失败)
	ERR_NEW_DOWNLOADER_FAIL = 30007
	//new analyzer error(新建解析器失败)
	ERR_NEW_ANALYZER_FAIL = 30008
	//new pipeline error(新建处理管道失败)
	ERR_NEW_PIPELINE = 30009

	/*
	 * scheduler error
	 */

	//scheduler args error(调度器参数错误)
	ERR_SCHEDULER_ARGS = 40001
	//get primary domian fail
	ERR_GET_PRIMARY_DOMAIN = 40002
	//get scheduler summary string fail
	ERR_GET_SCHEDULER_SUMMARY = 40003

	/*
	 * spider error
	 */

	// new spider fail
	ERR_SPIDER_NEW = 50001
	// not found spider
	ERR_SPIDER_NOT_FOUND = 50002
	// add spider fail
	ERR_ADD_SPIDER = 50003
	// scheduler not initilated
	ERR_SCHEDULER_NOT_INITILATED = 50004
	// compliling fail
	ERR_COMPLILE_FAIL = 50005
	// not compliled
	ERR_NOT_COMPLILED = 50006

	/*
	 * rpc error
	 */

	// dial fail
	ERR_RPC_CLIENT_DIAL = 60001
	// join cluster fail
	ERR_JOIN_CLUSTER = 60002
	// connect fail
	ERR_RPC_CLIENT_CONNECT = 60003
	// distribute fail
	ERR_RPC_CLIETN_DISTRIBUTE = 60004
	// RPC call fail
	ERR_RPC_CALL = 60005

	/*
	 * crawler error
	 */

	// new crawler fail
	ERR_CRAWLER_NEW = 70001
	// pop request fail
	ERR_REQUEST_POP = 70002

	/*
	 * cluster error
	 */

	// node not found
	ERR_NODE_NOT_FOUND = 80001

	/*
	 * parser/processor
	 */

	//unsupported model type
	ERR_UNSUPPORTED_MODEL_TYPE = 90001
	// get parsers source fail
	ERR_GET_PARSERS_SOURCE = 90002
	// get parser fail
	ERR_GET_PARSERS = 90003
	// get processors source fail
	ERR_GET_PROCESSORS_SOURCE = 90004
	// get processors fail
	ERR_GET_PROCESSORS = 90005
)
