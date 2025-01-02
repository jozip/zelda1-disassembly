function CompareFiles(
	[string] $leftPath,
	[string] $rightPath,
	[int] $bufferSize = 0x4000 )
{
	if ( $bufferSize -le 0 )
	{
		throw "Invalid buffer size"
	}

	$leftFile  = new-object IO.FileInfo (resolve-path $leftPath)
	$rightFile = new-object IO.FileInfo (resolve-path $rightPath)

	if ( !$leftFile.Exists -or !$rightFile.Exists -or ($leftFile.Length -ne $rightFile.Length) )
	{
		return $false
	}

	$leftBuf  = new-object byte[] $bufferSize
	$rightBuf = new-object byte[] $bufferSize

	try
	{
		$leftStream  = $leftFile.OpenRead()
		$rightStream = $rightFile.OpenRead()

		do
		{
			$bytesRead = $leftStream.Read( $leftBuf, 0, $bufferSize )
			[void] $rightStream.Read( $rightBuf, 0, $bufferSize )

			for ( $i = 0; $i -lt $bytesRead; $i++ )
			{
				if ( $leftBuf[$i] -ne $rightBuf[$i] )
				{
					return $false
				}
			}
		}
		while ( $bytesRead -eq $bufferSize )
	}
	finally
	{
		$leftStream.Close()
		$rightStream.Close()
	}

	return $true
}
