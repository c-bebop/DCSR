#include "Matrix_Test.h"
#include "load_matrix.h"

void SPMM_Test(const std::string filenameA, const std::string filenameB, const std::string filenameC);
void Matrix_Test(const std::string filename);
void createStreams();
void createStreams(const int ID);
void destroyStreams();
void destroyStreams(const int ID);

//#include "Fill_Tests.cu"
#include "SPMM_Tests.cu"

void createStreams(const int ID)
{
	for(int i=0; i<NUM_STREAMS; i++)
		cudaStreamCreate(&__multiStreams[ID][i]);
}

void destroyStreams(const int ID)
{
	for(int i=0; i<NUM_STREAMS; i++)
		cudaStreamDestroy(__multiStreams[ID][i]);
}

void createStreams()
{
	for(int i=0; i<NUM_STREAMS; i++)
		cudaStreamCreate(&__streams[i]);
}

void destroyStreams()
{
	for(int i=0; i<NUM_STREAMS; i++)
		cudaStreamDestroy(__streams[i]);
}

void Matrix_Test(const std::string filename)
{
	#if(MULTI_GPU == 1)
		//SPMMTests_Multi(filename);
	#else
		//SPMMTests(filename);
	#endif
}

void SPMM_Test(const std::string filenameA, const std::string filenameB, const std::string filenameC)
{
	SPMMTests(filenameA, filenameB, filenameC);
}

////////////////////////////////////////////////////////////////////////////////
//	Parse input file and run test
////////////////////////////////////////////////////////////////////////////////

void runTest(int argc, char** argv)
{
	if(argc != 2)
	{
		fprintf(stderr, "Invalid input...\n");
		fprintf(stderr, "Usage: CFA <testfile>\n");
		exit(1);
	}

	std::string filename(argv[1]);
	//Test(filename);
	Matrix_Test(filename);
}

int main(int argc, char **argv)
{
	fprintf(stderr, "TEST START\n");
	runTest(argc, argv);
	fprintf(stderr, "TEST COMPLETE\n");
	return 0;
}